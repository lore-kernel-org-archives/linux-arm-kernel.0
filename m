From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 May 2016 08:46:45 +0200
Subject: [PATCH v2 1/1] add missing UARTs pins and I2C entriesfor
 AllWinner H3 DTSI
In-Reply-To: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
References: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
Message-ID: <20160502064645.GK17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 19, 2016 at 03:50:39PM -0400, Martin Ayotte wrote:
> Hi everyone,
> 
> This patch is submit to provide endusers access to additional UARTs on
> AllWinner H3 SoC along with I2C ports.

Unfortunately, your patch cannot be applied in its current form, both
because of process and technical reasons:

  * Every commits should have a commit title and log. While you do
    have a title, you used the log to store your cover letter. This is
    an issue, because that will be kept in the git history, which is
    obviously something we don't want.
    If you want to make a cover letter, you can either send it as a
    separate mail, or after the "---" below that will be ignored when
    applying the mails.
    On the other hand, the commit log should be used to say why ?our
    doing this patch and why it was needed.

  * You do not have a Signed-off-by tag in your commit log. This and
    the point above is documented in Documentation/SubmittingPatches,
    please make sure to read that first.

  * Your mailer completely corrupted the patch when you sent it,
    replacing all tabs by spaces, and wrapping the longer lines. That
    means that the patch cannot be applied anymore. Please fix your
    mailer, or use one that just works, like git send-email.

  * Finally, like Chen-Yu already told you, you're doing several
    different things here in a single patch, while you should have
    done separate patches. From what I can see, you're adding pinctrl
    groups for the uart and i2c pins, and adding the i2c controller
    nodes. That should have been ideally 3 patches: 1 for the uart
    pinctrl groups, 1 for the i2c pinctrl groups, 1 for the i2c
    controller nodes. We also don't take pinctrl groups that are not
    enabled on any boards to keep the DT size as small as possible.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/9ea79816/attachment.sig>
