From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 11 Dec 2014 11:42:27 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <20141211044758.GH16827@intel.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
 <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
 <20141208130727.GK16827@intel.com>
 <CAJe_ZhfKFdrV8=oMiH0hJeOmGAmPNbZ7rUXsqN+Ak7PvOnZEmA@mail.gmail.com>
 <20141211044758.GH16827@intel.com>
Message-ID: <CAJe_ZhdeTp3RAm-QQu04XVF-oOppV2zx8_7G7MOTF+ziqzbvCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2014 at 10:17, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Dec 09, 2014 at 08:48:04PM +0530, Jassi Brar wrote:
>> As Russell pointed out, that ain't the case either.
>> So we are yet to figure out benefits of having explicit
>> issue_pending() after tx_submit().
> callback ?
>
The callback is set after prep() and before tx_submit(), but here we
talk after tx_submit().
