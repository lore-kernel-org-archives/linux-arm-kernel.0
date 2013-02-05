From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 16:30:45 +0100
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <51102E25.8040107@ti.com>
References: <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi>
 <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
 <20130204203358.GX4720@opensource.wolfsonmicro.com>
 <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
 <51102E25.8040107@ti.com>
Message-ID: <CACRpkdaUQ60W8Vmg3MpvP5uV+3jD3y4+9V2et4Ni+z-7k=aFTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 4, 2013 at 10:54 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> On 02/04/2013 04:11 PM, Linus Walleij wrote:

>> Cyril, just stack up the cookies and take a sweep over them to see
>> which ones are baked when the NAPI poll comes in -> problem
>> solved.
>
> You're assuming that cookies complete in order.  That is not necessarily
> true.

So put them on a wait list? Surely you will have a list of pending
cookies and pick from the front of the queue if there isn't a hole on
queue position 0.

Yours,
Linus Walleij
