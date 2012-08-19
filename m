From: shmulik.ladkani@gmail.com (Shmulik Ladkani)
Date: Sun, 19 Aug 2012 12:26:34 +0300
Subject: [PATCH 6/8] UBI: replace MTD_UBI_BEB_LIMIT with module parameter
In-Reply-To: <1345214124-5478-7-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
 <1345214124-5478-7-git-send-email-richard.genoud@gmail.com>
Message-ID: <20120819122634.252f1ea5@pixies.home.jungo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Fri, 17 Aug 2012 16:35:22 +0200 Richard Genoud <richard.genoud@gmail.com> wrote:
> +		      "MTD devices may be specified by their number, name, or path to the MTD character device node.\n"
> +		      "Optional \"vid_hdr_offs\" parameter specifies UBI VID header position to be used by UBI. (default value if 0 or not set)\n"
> +		      "Optional \"max_beb_per1024\" parameter specifies the maximum expected bad eraseblock per 1024 eraseblocks. (default value ("
> +		      __stringify(CONFIG_MTD_UBI_BEB_LIMIT) ") if 0 or not set)\n"

Looks like "mtd=/dev/mtd1,,25" is invalid, although we state "default
value if 0 or not set".

Also, lines are exceeding 80 chars, not sure this is more readable than
if they were broken.

Regards,
Shmulik
