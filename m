From: ccross@google.com (Colin Cross)
Date: Wed, 4 May 2011 23:50:52 -0700
Subject: Common clock and dvfs
In-Reply-To: <alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
Message-ID: <BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 11:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 4 May 2011, Colin Cross wrote:
>
>> Imagine a chip where a clock can feed devices A, B, and C. ?If the
>> devices are always clocked at the same rate, and can't gate their
>> clocks, the minimum voltage that can be applied to a rail is
>> determined ONLY by the rate of the clock.
>
> That's not so -- although admittedly it's a side issue, and not
> particularly related to DVFS.
>
> For example, the device may have some external I/O lines which need to be
> at least some minimum voltage level for the externally-connected device to
> function. ?This minimum voltage level can be unrelated to the device's
> clock frequency.

True, that was an oversimplificaiton. I meant the minimum voltage that
scales with clock frequencies only depends on the clock frequency, not
the device.  Devices do need to be able to specify a higher minimum
voltage, and the regulator api needs to handle it.
