From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Wed, 26 Jan 2011 06:14:11 +0000
Subject: [PATCH] davinci: tnetv107x: fix register indexing for GPIOs
	numbers >31
In-Reply-To: <1295993126-6841-1-git-send-email-hirosh.dabui@snom.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093F977AC9@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

davinci-linux-open-source-bounces at linux.davincidsp.com wrote:

> The bug implied the use of macros to access the relevant hardware
> register e.g. the driver code used the macro like this:
> 'gpio_reg_clear_bit(&reg->data_out, gpio)'
>
> But it has to be used like this:
> 'gpio_reg_clear_bit(reg->data_out, gpio)'.

Could the macro be made into an inline function so it can do type-checking
to avoid/catch this in future?

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
