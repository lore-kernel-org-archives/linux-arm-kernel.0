From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Jun 2017 16:11:29 -0300
Subject: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
In-Reply-To: <1923573.HjpiSnITgW@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <2668097.SlerkO2uVy@en-pc05>
 <20170613135847.GA7128@bhelgaas-glaptop.roam.corp.google.com>
 <1923573.HjpiSnITgW@en-pc05>
Message-ID: <CAOMZO5C03MwGkQSrJr-AeG98q84iyWnKj2GSvveJ6xKL+Y-9EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 2:52 AM, Sch?fegger Stefan
<Stefan.Schoefegger@ginzinger.com> wrote:

> device). The bitrate and de-emphasis must be switched. The driver (without
> this patches) does not allow to switch to gen2 because it falls back to gen1.
> It is impossible to generate the gen2 test pattern.

If you pass 'fsl,max-link-speed = <2>;' in your device tree, then it
will allow gen2.

>From Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt:

"- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
  compliant clock generator should be used and configured."

Wouldn't this solve the problem?
