From: msuchanek@suse.de (Michal =?UTF-8?B?U3VjaMOhbmVr?=)
Date: Wed, 14 Feb 2018 17:13:08 +0100
Subject: [PATCH 1/2] mmc: bcm2835: reset host on timeout
In-Reply-To: <20180214163649.3a0c9476@kitsune.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
Message-ID: <20180214165827.386b9bb1@kitsune.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Feb 2018 16:36:49 +0100
Michal Such?nek <msuchanek@suse.de> wrote:

> On Wed, 14 Feb 2018 15:58:31 +0100
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Michal,
> > 
> > Am 14.02.2018 um 15:38 schrieb Michal Suchanek:  
> > > The bcm2835 mmc host tends to lock up for unknown reason so reset
> > > it on timeout. The upper mmc block layer tries retransimitting
> > > with single blocks which tends to work out after a long wait.
> > >
> > > This is better than giving up and leaving the machine broken for
> > > no obvious reason.    
> > 
> > could you please provide more information about this issue (affected
> > hardware, kernel config, version, dmesg, reproducible scenario)?
> >   
> 

It tends to reproduce when upgrading a few packages with zypper and
otherwise at random during system operation. It seems that for my card
it worsens with age to some degree so perhaps it depends on the
fragmentation of the internal card flash.

Attaching dmesg and kernel config.

Thanks

Michal
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/73315328/attachment-0001.txt>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.txt.xz
Type: application/x-xz
Size: 45316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/73315328/attachment-0001.xz>
