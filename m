From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 11:00:52 +0200
Subject: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
In-Reply-To: <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160905090052.GG3532@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 05:36:30PM +0200, Neil Armstrong wrote:
> Add support for the PWM controller found in the Amlogic SoCs.
> This driver supports the Meson8b and GXBB SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pwm/Kconfig     |   9 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-meson.c | 528 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 538 insertions(+)
>  create mode 100644 drivers/pwm/pwm-meson.c

Hi Neil,

sorry for taking so long to review this. I had actually started to write
a review email since I had noticed a couple of slight oddities about the
driver structure (primarily this was about how channel-specific data was
split between struct meson_pwm_channel and struct meson_pwm_chip), but I
ended up making some changes to the driver in order to see what my
suggestions would look like, and if they would indeed improve things.
But once I had done that, I thought it a bit pointless to make that into
review comments and decided to just push what I had done and ask you to
take a look, and if you had no objections to the changes take the driver
for a spin to see if it still worked as expected.

One other thing I noticed is that your ->get_state() implementation only
reads the enable state, but from the looks of it it should be possible
to read period and duty cycle information from hardware as well. I'm not
going to reject the driver for that reason, just saying that it'd be
good to have that implemented sometime in the future.

I've pushed my modifications to the driver to the linux-pwm repository:

	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-next

Alternatively you can also take a look at the for-4.9/drivers branch,
but they're currently the same thing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/79564440/attachment.sig>
