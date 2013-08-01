From: timur@tabi.org (Timur Tabi)
Date: Wed, 31 Jul 2013 23:43:18 -0500
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <0DFB48290CDB0C4680160EBE62E8F9A809E9A2E0@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>	<1375187900-17582-3-git-send-email-B44344@freescale.com>
 <CAOZdJXW8uF_e2nQr3gAiMf4E5pvsH_S-ztAXvx9R7-nXyaZGag@mail.gmail.com>
 <0DFB48290CDB0C4680160EBE62E8F9A809E9A2E0@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <51F9E766.604@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Goel Arpit-B44344 wrote:
> PowerPC uses hardware timer registers provided by PowerPC architecture to implement spin_event_timeout(). These registers make
> PowerPC implementation of spin_event_timeout() more granular in comparison to ones using generic USECS_PER_JIFFY framework. This
> would handle those cases more granularly in which evaluation of "condition" is taking time or fails.

LOL, it seems I forgot how my own code works.  Thanks for the reminder. 
  For some reason, I thought the PowerPC version was also using 
'jiffies'.  The concern about using 'jiffies' makes a lot more sense now.

Almost every architecture has a timebase counter.  Wouldn't it make more 
sense to port tb_ticks_per_usec, get_tbl(), and tb_ticks_since() to 
other architectures instead?  I don't think 'jiffies' is granular enough 
for spin_event_timeout().
