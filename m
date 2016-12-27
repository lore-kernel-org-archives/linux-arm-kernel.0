From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Dec 2016 10:56:05 -0200
Subject: [PATCH 1/6] ARM: mach-mx31_3ds: Remove camera support
In-Reply-To: <CAM=E1R4L+BtFqAdRCUFzaZLkuZ7+8KUxO9iTkDqRz94RrOrz0Q@mail.gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
 <CAM=E1R4L+BtFqAdRCUFzaZLkuZ7+8KUxO9iTkDqRz94RrOrz0Q@mail.gmail.com>
Message-ID: <CAOMZO5B2NWDL=qBYYTOqtWdHnn3ONk52TYOudeVpmHnCSRDKwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tue, Dec 27, 2016 at 8:05 AM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> CSI_D5 is marked as "not floating" by default, as opposed to "input,
> pulled up" on many other pins on the i.MX31. That makes me wonder if
> it's best to keep the initialization of CSI_D5 and RI_DTE1 to make
> sure the pins are set to a defined state (that also will set the
> camera off).

After this patch the camera will not be powered by the mc13783 PMIC
anymore, so I think it is safe to remove the code that handles the
camera GPIOs.


> Will test the patch on hardware in a couple of days.

Thanks!
