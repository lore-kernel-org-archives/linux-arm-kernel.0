From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 Jan 2012 00:52:59 -0200
Subject: [PATCH 1/4] input: mc13783_ts: rename to mc13xxx_ts
In-Reply-To: <1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
 <1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Sun, Jan 29, 2012 at 8:51 PM, Marc Reilly <marc@cpdesign.com.au> wrote:
> Start moving this driver towards support for both mc13892 and mc13783.
>
> This patch simply renames mc13783 specific identifiers to the generic
> mc13xxx. A platform_device_id table is also added so that the driver
> is still created correctly for the mc13783 only.
>
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
> ?drivers/input/touchscreen/Kconfig ? ? ?| ? ?8 +-
> ?drivers/input/touchscreen/Makefile ? ? | ? ?2 +-
> ?drivers/input/touchscreen/mc13783_ts.c | ?259 -------------------------------
> ?drivers/input/touchscreen/mc13xxx_ts.c | ?267 ++++++++++++++++++++++++++++++++
> ?4 files changed, 272 insertions(+), 264 deletions(-)
> ?delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
> ?create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c

For the rename, it is better to do:
git mv  drivers/input/touchscreen/mc13783_ts.c
drivers/input/touchscreen/mc13xxx_ts.c

git commit -a

and then git format -M -1 , as it will detect the rename.

Regards,

Fabio Estevam
