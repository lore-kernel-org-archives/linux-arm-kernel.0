From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Jul 2015 16:14:40 +0200
Subject: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
In-Reply-To: <559FBCD3.4050402@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710081148.GB1528@katana> <559FBCD3.4050402@linaro.org>
Message-ID: <20150710141440.GA6594@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 06:08:43PM +0530, Vaibhav Hiremath wrote:
> 
> 
> On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
> >On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
> >>Normally i2c controller works as master, so slave addr is not needed, or it
> >>will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
> >>the same i2c address with controller.
> >
> >Just to make sure: Does it? As I read the code, slave interrupts are
> >enabled later only when slave mode is selected? Is that a HW bug? And if
> >so, can't the code just be moved into this #ifdef block later?
> >
> 
> Yes we could, infact I thought about it;
> but I would break recommended sequence here.

And did you set the "own slave address" to a value which one of your
existing i2c slaves also has (without enabling slave mode)? Did it
disturb communication?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/9bbb00c2/attachment.sig>
