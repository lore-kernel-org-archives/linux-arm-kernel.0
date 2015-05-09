From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 9 May 2015 11:42:11 +0300
Subject: [PATCH v3 4/4] remoteproc/wkup_m3: add a remoteproc driver for TI
 Wakeup M3
In-Reply-To: <1427917039-43206-5-git-send-email-d-gerlach@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-5-git-send-email-d-gerlach@ti.com>
Message-ID: <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add a remoteproc driver to load the firmware and boot a small
> Wakeup M3 processor present on TI AM33xx and AM43xx SoCs. This
> Wakeup M3 remote processor is an integrated Cortex M3 that allows
> the SoC to enter the lowest possible power state by taking control
> from the MPU after it has gone into its own low power state and
> shutting off any additional peripherals.

>From a remoteproc point of view this looks generally ok.

The only non-standard remoteproc aspect here is the handling of the
internal memories. Can you please generally describe how are these
memories being used in the context of remoteproc? how does the
resource table of your firmware look like - do you also have carveouts
or other resources?

Thanks,
Ohad.
