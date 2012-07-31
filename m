From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 15:56:15 +0100
Subject: [PATCH 1/5] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20120731145614.GZ4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:45:40PM +0100, Lee Jones wrote:
> If a list of widgets is provided and one of them fails to be added as
> a control, the present semantics fail all subsequent widgets. A better
> solution would be to only fail that widget, but pursue in attempting
> to add the rest of the list.

To reiterate, this is in *no* way urgent or even a bug fix.

>  			dev_err(dapm->dev,
>  				"ASoC: Failed to create DAPM control %s\n",
>  				widget->name);
> -			ret = -ENOMEM;
> -			break;

Indeed, removing the error return is a regression.
