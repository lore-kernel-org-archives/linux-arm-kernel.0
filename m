From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Feb 2014 21:41:48 +0100
Subject: [PATCH 0/5] mv64xxx updates
In-Reply-To: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Message-ID: <52FD2E0C.10609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 13/02/2014 21:36, Wolfram Sang wrote:
> So, this is a series I came up with trying to fix the issue found by Kevin.
> Patches 1+2 are hopefully fixing the bug (in theory, I don't have the HW).
> Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), then 4+5
> are further cleanup possibilities. And there is still more potential, I mainly
> wanted to give some inspiration and awareness that the driver could need some
> more love. Please test at least 1+2, comments to 3-5 very welcome.
> 
> Sorry for the delay, I got distracted by an NMI.
> 

Thanks for this series, indeed the code looks better.

I will test it tomorrow and let you know if it fixed the bug.
I will also take time to review the RFC patches.

Greogry


> Wolfram Sang (5):
>   i2c: mv64xxx: put offload check into offload prepare function
>   i2c: mv64xxx: refactor message start to ensure proper initialization
>   i2c: mv64xxx: refactor send_start
>   i2c: mv64xxx: directly call send_start when initializing transfer
>   i2c: mv64xxx: refactor initialization for new msgs
> 
>  drivers/i2c/busses/i2c-mv64xxx.c | 67 ++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 40 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
