From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed, 18 May 2011 09:36:16 -0400
Subject: [PATCH 2/9] davinci: sram: ioremap the davinci_soc_info specified
	sram regions
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CFDCA6C@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
	<80c0c2ff5a39baf6140c08460c2691b178c038c0.1305668470.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024CFDCA6C@dbde02.ent.ti.com>
Message-ID: <BANLkTiksPym1qb172M5pm42NNfE6MhgVVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Thanks for the review.

On Wed, May 18, 2011 at 9:18 AM, Nori, Sekhar <nsekhar@ti.com> wrote:

[...]

>> ? ? ? if (len) {
>> ? ? ? ? ? ? ? len = min_t(unsigned, len, SRAM_SIZE);
>> - ? ? ? ? ? ? davinci_pv_pool = pv_pool_create((void *)SRAM_VIRT,
>> + ? ? ? ? ? ? addr = ioremap(davinci_soc_info.sram_phys, len);
>> + ? ? ? ? ? ? if (!addr)
>> + ? ? ? ? ? ? ? ? ? ? return -EIO;
>
> -ENOMEM here (for the next time you post). See Sergei's
> mail on error codes below. Useful stuff.
>
> https://patchwork.kernel.org/patch/47365/

Will do. Thanks for the useful reference also (and to Sergei for writing it).

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
