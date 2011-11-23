From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 23 Nov 2011 08:15:28 +0100
Subject: [PATCH 17/17] ASoC: Tegra+WM8903 machine: Add device tree binding
In-Reply-To: <1322011285-4002-18-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-18-git-send-email-swarren@nvidia.com>
Message-ID: <20111123071528.GA12558@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> From: John Bonesio <bones@secretlab.ca>
> 
> This driver is parameterized in two ways:
> 
> a) Platform data, which supplies a set of GPIOs used by the driver.
>    These GPIOs can now be parsed out of device tree.
> 
> b) Machine-specific DAPM route arrays embedded into the ASoC machine
>    driver itself. The driver picks the appropriate array to use using
>    machine_is_*(). This array can now be parsed straight out of device
>    tree, allowing the machine driver to be completely machine agnostic.
> 
> swarren applied the following modifications:
> * Moved all pdata and DT parsing into one place.
> * Added DAPM route parsing from DT.
> * Added tegra_pcm device registration.
> * Documented DT binding.
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/sound/tegra-audio-wm8903.txt          |   63 +++++++++
>  sound/soc/tegra/tegra_wm8903.c                     |  133 ++++++++++++++++----
>  2 files changed, 171 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
[...]
> diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
[...]
> @@ -262,6 +266,83 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
>  		return ret;
>  	}
>  
> +	pdata = &machine->pdata;
> +	np = card->dev->of_node;
> +
> +	if (card->dev->platform_data) {
> +		*pdata = *(struct tegra_wm8903_platform_data *)
> +						card->dev->platform_data;
[...]

Minor nit: perhaps this should use memcpy() instead?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/679042e8/attachment.sig>
