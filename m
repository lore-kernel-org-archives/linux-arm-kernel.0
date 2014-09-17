From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Sep 2014 11:23:26 -0600
Subject: [PATCH] BCM2835: Add I2S driver to device tree
In-Reply-To: <20140917164436.GJ7960@sirena.org.uk>
References: <1404895825-25668-1-git-send-email-broonie@kernel.org>
 <5418E985.5090708@wwwdotorg.org> <20140917164436.GJ7960@sirena.org.uk>
Message-ID: <5419C38E.4010709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 10:44 AM, Mark Brown wrote:
> On Tue, Sep 16, 2014 at 07:53:09PM -0600, Stephen Warren wrote:
>> On 07/09/2014 02:50 AM, Mark Brown wrote:
>>> From: Mark Brown <broonie@linaro.org>
>
>>> +		bcm2835_i2s: i2s at 7e203000 {
>>> +			compatible = "brcm,bcm2835-i2s";
>>> +			reg = <0x7e203000 0x20>,
>>> +			      <0x7e101098 0x02>;
>>> +
>>> +			dmas = <&dma 2>,
>>> +			       <&dma 3>;
>>> +			dma-names = "tx", "rx";
>>> +		};
>
>> This node is already there (and even edited in this patch), so I dropped
>> that hunk.
>
> Right, not sure what went on with applying it upstream originally but it
> looks like git rebase didn't figure out what was going on well - the
> bcm2835_i2s is needed so we can reference the node.  I'll probably get
> round to resending an incremental patch.

Oh right, I guess I did drop the addition of that label when I dropped 
that node.

The board DT could doesn't necessarily require a label though; it could 
just repeat the node name:

/ {
     i2s at 7e203000 {
         ... extra properties

Still, it looks like we typically use labels to reference nodes in 
bcm2835-*.dts, so adding the label would indeed be a good idea.
