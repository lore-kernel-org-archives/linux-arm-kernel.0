From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 17 Jun 2016 12:16:48 -0500
Subject: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
In-Reply-To: <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
Message-ID: <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
> Add binding doc for generic usb power sequence driver, and update
> generic usb device binding-doc accordingly.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
>  .../devicetree/bindings/usb/usb-device.txt         |  2 ++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
>
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> new file mode 100644
> index 0000000..8ad98382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> @@ -0,0 +1,31 @@
> +The power sequence for generic USB Devices
> +
> +Some hard-wired USB devices need to do power sequence to let the
> +device work normally, the typical power sequence like: enable USB
> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> +lacks of such code to do it, it may cause some hard-wired USB devices
> +works abnormal or can't be recognized by controller at all. The
> +power sequence will be done before this device can be found at USB
> +bus.
> +
> +Required properties:
> +- compatible : contains "usb-pwrseq-generic".

In case I have not been clear, no.

I am not going to accept anything along the lines of the current mmc
pwrseq. I am basically okay with Krzysztof's proposal as it is *only*
an added property and not a duplication of information. I'd suggest
you figure out how to make the kernel work with that rather than
trying to work-around whatever kernel limitations there are.

Rob
