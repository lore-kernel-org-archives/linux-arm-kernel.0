From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Thu, 10 Dec 2015 16:36:19 -0500
Subject: [PATCH 0/3] DT labels for connector device mapping
In-Reply-To: <1449782473-20880-1-git-send-email-robh@kernel.org>
References: <1449782473-20880-1-git-send-email-robh@kernel.org>
Message-ID: <5669F053.4080509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 04:21 PM, Rob Herring wrote:
> Having a common connector interface across different platforms can be 
> problematic for determining which SOC device is connected to which 
> connector pins. The standard DT property "label" is intended to provide 
> a human readable name for a device and can be used to provide this 
> information. Then userspace can can read the label to determine the 
> device mapping. For example:
>
> for f in $(ls -d /sys/class/tty/tty*); do
>   label=$(cat $f/device/of_node/label)
>   if [ "$label" = "LS-UART1" ]; then
>     # you've found UART1, so do something with it.
>     # $f/dev is the major:minor for the /dev node
>   fi
> done
>
> This series adds labels on hikey and dragonboard 410c devices for the 
> low speed and high speed connectors. Not tested at all.

should we then use the line-name property on the GPIOs to have a common naming
convention across all 96Boards boards?
