From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 20 Feb 2012 22:35:38 +0200
Subject: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
In-Reply-To: <4F41FE75.4070003@ti.com>
References: <1329320246-1548-1-git-send-email-peter.ujfalusi@ti.com>
 <CANOLnONVm47DmMv8MdU1Y_Nx-387SZ5MBHwjO4cxkQ_caJ5dWA@mail.gmail.com>
 <4F41FE75.4070003@ti.com>
Message-ID: <CANOLnOM9nJ-ukM6z6w7uv8obSc+JO-0EbcSotwNKqW6o7tZNCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 10:04 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hi Gra?vydas,
>
> On 02/18/2012 11:43 PM, Grazvydas Ignotas wrote:
>> On Wed, Feb 15, 2012 at 5:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> Comments, testers are welcome...
>>
>> Tried these on current mainline and they break sound on pandora:
>> # aplay /dev/urandom
>> Playing raw data '/dev/urandom' : Unsigned 8 bit, Rate 8000 Hz, Mono
>> [ ? 81.306304] omap-mcbsp: clks: could not clk_set_parent() to pad_fck
>> [ ? 81.313110] ASoC omap3pandora: can't set cpu system clock
>> [ ? 81.319244] asoc: machine hw_params failed
>> aplay: set_params:1022: Unable to install hw params:
>>
>> I've retried without these patches to confirm it works like that, and it did.
>
> Thanks for testing the series.
> The issue is that I forgot to remove the pm_runtime_put/get_sync calls
> from the moved mcbsp.c file.
> Can you manually remove these calls from sound/soc/omap/mcbsp.c ?
> It will fix the issue I believe.

Yup that helped, playback and recording on OMAP3 pandora
Tested-by: Grazvydas Ignotas <notasas@gmail.com>


-- 
Gra?vydas
