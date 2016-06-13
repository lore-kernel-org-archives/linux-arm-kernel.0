From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 13 Jun 2016 15:43:15 +0800
Subject: [PATCH 3/5] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <20160608191133.GA14655@rob-hp-laptop>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
 <1464947790-22991-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160606141438.GA9510@rob-hp-laptop> <5755BCAE.6060307@gmail.com>
 <20160608191133.GA14655@rob-hp-laptop>
Message-ID: <CAGb2v66y8AbQppGmaxJeVsfE0OvG5WMW-HuDAivFu96XN2pLAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Jun 9, 2016 at 3:11 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jun 06, 2016 at 08:10:54PM +0200, Corentin LABBE wrote:
>> Le 06/06/2016 16:14, Rob Herring a ?crit :
>> > On Fri, Jun 03, 2016 at 11:56:28AM +0200, LABBE Corentin wrote:
>> >> This patch adds documentation for Device-Tree bindings for the
>> >> Allwinner sun8i-emac driver.
>> >>
>> >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
>> >> ---
>> >>  .../bindings/net/allwinner,sun8i-emac.txt          | 64 ++++++++++++++++++++++
>> >>  1 file changed, 64 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>> >> new file mode 100644
>> >> index 0000000..cf71a71
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>> >> @@ -0,0 +1,64 @@
>> >> +* Allwinner sun8i EMAC ethernet controller
>> >> +
>> >> +Required properties:
>> >> +- compatible: "allwinner,sun8i-a83t-emac", "allwinner,sun8i-h3-emac",
>> >> +          or "allwinner,sun50i-a64-emac"
>> >> +- reg: address and length of the register sets for the device.
>> >> +- reg-names: should be "emac" and "syscon", matching the register sets
>> >
>> > Is syscon shared with other devices? Your example only has 1 reg
>> > address.
>> >
>>
>> The example is bad, emac and syscon are two distinct regspaces.
>> I will correct the example.
>
> And the syscon registers are not shared with anything else? Typically,
> syscon registers would be a separate node not part of this blocks
> registers. The main thing is make sure you are not creating overlapping
> register addresses.

These syscon registers are in a separate address range, like a glue layer
over the underlying EMAC hardware. There are only 2 registers defined in
that address range, and this particular one is used only for EMAC related
controls.

The other register is not used anywhere in the kernel. It's a readonly
register that gives the SoC revision. IIRC there was some work to add
per-platform functions to support this, but we haven't the need to use
it yet.

Hope this clears things up.

Regards
ChenYu
