From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Mar 2012 09:12:31 -0300
Subject: [PATCH v2] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <1332935527-21414-1-git-send-email-alexg@meprolight.com>
References: <1332935527-21414-1-git-send-email-alexg@meprolight.com>
Message-ID: <CAOMZO5DE0wcdbk7xbXuOFKJ=NNtSrWTPaLjRAdDfewOmPR-eVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 8:52 AM, Alex Gershgorin <alexg@meprolight.com> wrote:
> This version rebased for v3.4, also removes ranges from regulators
> who do not have consumers and adds consumers for same regulators.

In your subject: prefix it with "ARM" as this patch should go via the arm tree.

Also, do not put comments about kernel version in the commit log.
If you want to talk about kernel version/patch history you can do so
below the --- line.

...
> +static struct regulator_consumer_supply vcam_consumers[] = {
> + ? ? ? /* sgtl5000 */
> + ? ? ? REGULATOR_SUPPLY("VDDA", "1-000a"),

This should be "0-000a" instead.
