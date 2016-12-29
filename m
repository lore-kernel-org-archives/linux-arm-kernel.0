From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 29 Dec 2016 10:07:42 +0100
Subject: [BUG] ARM64: amlogic: gxbb: unhandled level 2 translation fault
 (11)
In-Reply-To: <20161224140028.4205-1-xypron.glpk@gmx.de>
References: <20161224140028.4205-1-xypron.glpk@gmx.de>
Message-ID: <478f1429-03f2-a944-8d47-3757a4d44a40@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2016 03:00 PM, Heinrich Schuchardt wrote:
> When trying to run sddm on an Hardkernel Odroid C2 I invariably run into the
> translation fault below.
> 
> The following mail thread relates this kind of problem to TLB (translation
> lookaside buffer) broadcasting.
> 
> https://lkml.org/lkml/2014/4/15/207
> 
> [ 3163.014263] sddm[1851]: unhandled level 2 translation fault (11) at 0x00000160, esr 0x82000006
> [ 3163.017287] pgd = ffff80007bf86000
> [ 3163.020589] [00000160] *pgd=000000007a8a3003
> [ 3163.024733] , *pud=000000007be9c003
> [ 3163.028095] , *pmd=0000000000000000
> 
> 
> [ 3163.033026] CPU: 1 PID: 1851 Comm: sddm Not tainted 4.9.0-next-20161212-r022-arm64 #1
> [ 3163.040831] Hardware name: Hardkernel ODROID-C2 (DT)
> [ 3163.045698] task: ffff80007bc6d780 task.stack: ffff80007c524000
> [ 3163.051563] PC is at 0x160
> [ 3163.054231] LR is at 0xffff9a9fbc98
> [ 3163.057686] pc : [<0000000000000160>] lr : [<0000ffff9a9fbc98>] pstate: 40000000
> [ 3163.065022] sp : 0000ffffd7180130
> [ 3163.068281] x29: 0000ffffd7180130 x28: 0000ffffd7180288 
> [ 3163.073538] x27: 0000ffff9aa94000 x26: 0000000000000001 
> [ 3163.078798] x25: 0000000000000000 x24: 0000ffffd7180410 
> [ 3163.084060] x23: 000000000e0c2190 x22: 000000000e0ca5c0 
> [ 3163.089322] x21: 0000ffff9ac35000 x20: 0000000000454fa9 
> [ 3163.094583] x19: 0000000000454fa8 x18: 000000000e0b5938 
> [ 3163.099843] x17: 0000ffff9a3f2988 x16: 0000ffff9ac36aa0 
> [ 3163.105105] x15: 0000000000000000 x14: 0000000000000000 
> [ 3163.110367] x13: 6d00640064007300 x12: 0800000005000000 
> [ 3163.115627] x11: 0000040000000000 x10: 0000a00000000000 
> [ 3163.120889] x9 : 00003fffffffffff x8 : 0000000000000000 
> [ 3163.126150] x7 : 000000000e0cb520 x6 : 0000000000454fc0 
> [ 3163.131412] x5 : 0000ffffd717ffd8 x4 : 000000000e0cb510 
> [ 3163.136680] x3 : 0000000000000004 x2 : f2f9022b551b3900 
> [ 3163.141935] x1 : 0000000000000160 x0 : 000000000e0ca5c0 
> 
> Best regards
> 
> Heinrich Schuchardt

Hi Heinrich,

I personally never had this issue even while loading huge applications loke LibreOffice and Gnome environment.

I will have a look and try to reproduce this issue, can you provide us your configuration and user-space complete use case ?

Neil
