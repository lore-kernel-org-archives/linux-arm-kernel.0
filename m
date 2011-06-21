From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 13:02:48 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <20110621185356.GJ23234@n2100.arm.linux.org.uk>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<4E00E3D2.6050602@firmworks.com>
	<BANLkTiny9xDwiUww9Ys+jQZ0SHdQATABUA@mail.gmail.com>
	<20110621185356.GJ23234@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikHTSgowpUhMCcOMXk_oQd4Ue7S3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 12:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 21, 2011 at 12:42:14PM -0600, Grant Likely wrote:
>> On Tue, Jun 21, 2011 at 12:32 PM, Mitch Bradley <wmb@firmworks.com> wrote:
>> > I wonder if it makes sense to create a new device node "/linux-devices" to express a desired mapping from device nodes to /dev entries? ?The properties could be the names of device special files and the values the corresponding node phandles.
>>
>> I've been trying /really/ hard to avoid doing something like that
>> because a lot of the time the desired Linux dev name is a
>> implementation detail, and a potentially unstable one at that. ?If
>> Linux requires certain devices to have certain names because that is
>> how it hooks up clocks
>
> As I keep on saying, we don't _have_ to have to match on device name.
> If DT can come up with a better way to bind a clock to a particular
> device/connection name then DT can provide its own clk_get()
> implementation which does that.

Sorry, I overstated the situation.  My point is only that I don't want
encode how Linux currently views the world into the DT, because
implementation details can and do change.

g.
