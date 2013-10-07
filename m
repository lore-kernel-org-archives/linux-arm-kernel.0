From: robdclark@gmail.com (Rob Clark)
Date: Mon, 7 Oct 2013 10:59:39 -0400
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007110902.GL12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGsqGYj7_tZdzrsmUxExs6wm838dYPFhBdc8wqVC6mTxmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 7:09 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 07, 2013 at 12:48:20PM +0200, Jean-Francois Moine wrote:
>> On Mon, 7 Oct 2013 10:44:04 +0100
>> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>
>> > On Mon, Oct 07, 2013 at 11:18:07AM +0200, Jean-Francois Moine wrote:
>>       [snip]
>> > > It seems we are going backwards: as the Armada based boards will soon
>> > > move to full DT (mvebu), you are making an exception for the Cubox, so
>> > > that there should be Cubox specific kernels. I don't like that...
>> >
>> > *Ignored*.  You know why.
>>
>> Sorry. I don't see why. May you explain again?
>
> I don't run DT because DT lacks most of the features I require on the
> cubox.  Therefore I can't develop for DT.  Simple.

Jean-Fran?ois, just as an aside, I really don't think code that can be
shared, like tda998x, should encode a DT requirement.. there are
plenty of platforms that don't use DT (arm isn't everything, and last
I heard aarch64 was going to be ACPI).

Beyond that, it is a driver decision whether or not to support only-DT
or DT + other.. and as long as there is a common board which can use
the driver but which is not DT, there is probably a compelling reason
to still support the non-DT case.

BR,
-R
