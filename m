From: pza@pengutronix.de (Philipp Zabel)
Date: Mon, 9 Jun 2014 13:23:11 +0200
Subject: [PATCH 1/9] reset: add the Berlin reset controller driver
In-Reply-To: <53958D52.2050402@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-2-git-send-email-antoine.tenart@free-electrons.com>
 <53958D52.2050402@gmail.com>
Message-ID: <20140609112311.GA22176@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Mon, Jun 09, 2014 at 12:32:50PM +0200, Sebastian Hesselbarth wrote:
> I currently have no way to look it up myself, but is reset API providing
> a way to deal with phandle+specifier with more than one parameter?

You could provide a custom rcdev->of_xlate callback and encode
multiple phandle args into the reset line "index".

static int of_reset_xlate(struct reset_controller_dev *rcdev,
                          const struct of_phandle_args *reset_spec)
{
	return reset_spec->args[0] * 32 + reset_spec->args[1];
}

> Chip-ctrl has a bunch of other reset bits spread over the regset, having
> the offset encoded in the specifier would save us some SoC specific
> boiler plate, i.e.
> 
> reset = <&chip 0x104 14>;

That should be possible.

regards
Philipp
