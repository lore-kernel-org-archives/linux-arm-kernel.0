From: a.zummo@towertech.it (Alessandro Zummo)
Date: Thu, 19 Dec 2013 18:40:24 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <87d2kslphr.fsf@natisbad.org>
References: <87siton6ke.fsf@natisbad.org>
 <20131219173857.0a546b99@linux.lan.towertech.it>
 <87d2kslphr.fsf@natisbad.org>
Message-ID: <20131219184024.2a649328@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Dec 2013 18:28:16 +0100
arno at natisbad.org (Arnaud Ebalard) wrote:

> >  Yes, Andrew usually pick those.   
>
> I guess he should be put in the MAINTAINERS file then. Otherwise,
> get_maintainer.pl script can not do its job correctly and people
> end up thinking you should be the one handling those.

 That makes sense, I'll leave the decision add his email to Andrew. 


> > I do not maintain a separate tree due to most RTCs being specifit to a
> > subsytem.   
> 
> I do not understand: the chip is generic, i.e. this is not a RTC chip
> specific to a given SoC (like rtc-mv.c is for instance). Can you be
> more specific?

 Yes, this chip is generic, but most aren't. Some of those who
 are generic, are strictly connected to a particular system/board, 
 and they end up in that system's tree. Most of the drivers
 are pretty small.
 

> >  Regarding your patch, please do not add entries to /proc.
> >  Use sysfs if you need.  
> 
> Well, this is what is currently described in the documentation
> (Documentation/rtc.txt), in drivers/rtc/rtc-test.c driver and what
> many drivers do (AFAICT, 22/125).

 This needs to be fixed as well. Documentation.txt does not suggest
 to add arbitrary values to the procfs. "many do" does not apply.


> Additionally, I only provide some additional info for an existing
> file: the /proc entry is created by the drivers/rtc/class.c as
> soon as someone selects CONFIG_RTC_INTF_PROC.

 I know, but that makes the procfs entry a mess. sysfs is the way,


> Do you want me to send a v7 w/ the .proc helper removed or leave
> things as they are and Ack the patch as is?

 Unless absolutely needed, I'd prefer if you can remove them
 or move to sysfs.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
