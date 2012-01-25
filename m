From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 25 Jan 2012 18:24:28 +0200
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F200F64.9060203@monstr.eu>
References: <4F1EE861.4030405@monstr.eu>
 <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
 <4F1FF870.3000105@monstr.eu>
 <CAK=WgbZwaxMPsMiNcq5yFvBLrcODqGgDT6b=mmQ91JBVtTEyXA@mail.gmail.com>
 <4F200F64.9060203@monstr.eu>
Message-ID: <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 4:19 PM, Michal Simek <monstr@monstr.eu> wrote:
> I started with pur vanilla kernel and patches from your tree
> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
> for-next branch
> but then I had to moved to for-next-acked-merged because in the origin
> one were some problems.

Unlike for-next-acked-merged, the other branches aren't rebased and
therefore have merge conflicts with 3.3 material; that's intentional.

> Do you have any kernel tree with CMA just for sure?

Not a 3.3-based one, so I recommend you to just merge Marek's branch directly.

I'll soon create a full-fledged 3.3 branch though, so you may want to
wait a bit until I get to it.

> What do you use for firmware replacing?
> Just remove kernel module and load different one?

If your driver boots the remote core on its ->probe() handler, then
yes, you need to unbind and bind the device.

One way is to unload and load the driver, but you can also use the
bind/unbind sysfs files of your driver (echo -n device-name >
/sys/..../{un}bind).

Regards,
Ohad.
