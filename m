From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 13:06:22 +0100
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <1404215726-2480-1-git-send-email-broonie@kernel.org>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
Message-ID: <20140701120622.GJ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 12:55:26PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Even though we mostly use GPIO descriptors internally we still use
> gpio_request_one() to request so we need to pair that with gpio_free() to
> release the GPIO.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mark Brown <broonie@linaro.org>

This doesn't explain the reason...  I see the current GPIO code doing this:

void gpio_free(unsigned gpio)
{
        gpiod_free(gpio_to_desc(gpio));
}
EXPORT_SYMBOL_GPL(gpio_free);

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
