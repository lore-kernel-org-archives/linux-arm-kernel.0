Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B7C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:21:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDF421841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eb3FYRV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDF421841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tk1CgdESY0K36A7NMLQYs1vSwnPKODGMODQvEOzeBEU=; b=eb3FYRV6at1Dt4
	zoUQINAW8/CVQYNMGhcMTRCd38E0YMxObHTVCdhxQpQH28+uRuI5Pu07v4XKpJKO/RNg4BtykCmCY
	RFLhKEG9sYxGsHHWFXYpX2vpWKMu88PtPLYHyv8ZM0Cl6bzdhNOBcJiwNWtHhTWuBoD7vdX4FfpCI
	fdrzwuHOA84tNUnu5Xxn9VE9+F27nLBe4xyGS8sHlsWDeR6w2nqRzqHndGxfVhXqcpiGY6KJgFehp
	ELjdFrt5ELKFuNwibn5VZwAh8/HrsWworCCwN9QD0jwUKp/vUHQr1c1HijpFKpOrfRCMPA8Iiq++1
	b/nMRTCB8QsVn1VkK6bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ2CZ-0002AY-Bx; Mon, 17 Dec 2018 23:21:31 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ2CV-0001yz-NJ
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 23:21:29 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2018 15:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; d="scan'208";a="119617281"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146])
 ([10.122.105.146])
 by orsmga001.jf.intel.com with ESMTP; 17 Dec 2018 15:21:15 -0800
Subject: Re: [RESEND 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager
 abstraction
To: Arnd Bergmann <arnd@arndb.de>
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
 <1542125174-8204-2-git-send-email-thor.thayer@linux.intel.com>
 <CAK8P3a1+LKakyD_gJTiNqKwNuP2Ptr_Wj4zJXf=+SDHSJHbexA@mail.gmail.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <183b18b9-55f4-55d0-b1f6-674a6df49d1b@linux.intel.com>
Date: Mon, 17 Dec 2018 17:23:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1+LKakyD_gJTiNqKwNuP2Ptr_Wj4zJXf=+SDHSJHbexA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_152127_781009_8C7A72DD 
X-CRM114-Status: GOOD (  38.50  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: thor.thayer@linux.intel.com
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>,
 Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Networking <netdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Lee Jones <lee.jones@linaro.org>,
 David Miller <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On 12/14/18 6:36 AM, Arnd Bergmann wrote:
> On Tue, Nov 13, 2018 at 5:03 PM <thor.thayer@linux.intel.com> wrote:
>>
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> The SOCFPGA System Manager register block aggregate different
>> peripheral functions into one place.
>> On 32 bit ARM parts, the syscon framework fits this problem well.
>> On 64 bit ARM parts, the System Manager can only be accessed by
>> EL3 secure mode. Since a SMC call to EL3 is required, a new
>> driver using regmaps similar to syscon was created that handles
>> the SMC call.
>> Since regmaps abstract out the underlying register access, the
>> changes to drivers using System Manager are minimal.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> Resend - update use_single_rw to use_single_read and
>>           use_single_write which was added in 4.20.
> 
> Sorry for stepping in late here, I forgot to review it earlier and
> Lee had to remind me to take a look.
> 
:) Thank you for the review and comments!

>> +static const struct regmap_config s10_sysmgr_regmap_cfg = {
>> +       .name = "s10_sysmgr",
>> +       .reg_bits = 32,
>> +       .reg_stride = 4,
>> +       .val_bits = 32,
>> +       .reg_read = s10_protected_reg_read,
>> +       .reg_write = s10_protected_reg_write,
>> +       .fast_io = true,
>> +       .use_single_read = true,
>> +       .use_single_write = true,
>> +};
> 
> The new regmap seems fine to me, that looks like a good way
> of abstracting the two hardware methods.
> 
>> +/**
>> + * socfpga_is_s10
>> + * Determine if running on Stratix10 platform.
>> + * Return: True if running Stratix10, otherwise false.
>> + */
>> +static int socfpga_is_s10(void)
>> +{
>> +       return of_machine_is_compatible("altr,socfpga-stratix10");
>> +}
> 
> I don't really like the way you are checking for a specific here
> here though, that is something that should only be done in
> an absolute emergency when there is no way of fixing the
> device tree files.
> 
> Since this is a new driver for a device that is not used in
> mainline kernels yet (AFAICT), let's fix the binding and add
> a proper detection method here.
> 
Thank you. I'm not completely clear on this. Are you saying this 
function should test for a new compatible that is assigned to Stratix10 
in the binding ("altr,sys-mgr-s10") instead of the machine name?

>> +
>> +/**
>> + * of_sysmgr_register
>> + * Create and register the Altera System Manager regmap.
>> + * Return: Pointer to new sysmgr on success.
>> + *         Pointer error on failure.
>> + */
>> +static struct altr_sysmgr *of_sysmgr_register(struct device_node *np)
>> +{
>> +       struct altr_sysmgr *sysmgr;
>> +       struct regmap *regmap;
>> +       u32 reg_io_width;
>> +       int ret;
>> +       struct regmap_config sysmgr_config = s10_sysmgr_regmap_cfg;
>> +       struct resource res;
>> +
>> +       if (!of_device_is_compatible(np, "altr,sys-mgr"))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       sysmgr = kzalloc(sizeof(*sysmgr), GFP_KERNEL);
>> +       if (!sysmgr)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       if (of_address_to_resource(np, 0, &res)) {
>> +               ret = -ENOMEM;
>> +               goto err_map;
>> +       }
>> +
>> +       /* Need physical address for SMCC call */
>> +       sysmgr->base = (void __iomem *)res.start;
> 
> The cast here seems really ugly. Instead of mixinx up
> address spaces, how about adding a resource_size_t
> member in the sysmgr structure?
> 
Yes. I will change.

>> +        * search for reg-io-width property in DT. If it is not provided,
>> +        * default to 4 bytes. regmap_init will return an error if values
>> +        * are invalid so there is no need to check them here.
>> +        */
>> +       ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
>> +       if (ret)
>> +               reg_io_width = 4;
> 
> How likely is it that this would ever not be four bytes? It looks
> like you just copied this from syscon, but it really should not be
> needed.
> 
Yes. I will change.

>> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
>> +{
>> +       struct altr_sysmgr *sysmgr = NULL;
>> +
>> +       if (!socfpga_is_s10())
>> +               return syscon_node_to_regmap(np);
> 
> Why do you go through syscon here? Doesn't this add a lot of complexity?
> 
> I'd suggest using regmap_init_mmio() directly and open-coding the
> initialization you need as you do for the s10 case.
> 
Yes. It is more complex but I was concerned about re-implementing large 
parts of syscon for the ARM32 case.

However, re-implementing it will simplify the driver and keep both ARM32 
and ARM64 together. Thanks for the suggestion - I will change it.

>> +       if (!p_sysmgr)
>> +               sysmgr = of_sysmgr_register(np);
>> +       else
>> +               sysmgr = p_sysmgr;
>> +
>> +       if (IS_ERR_OR_NULL(sysmgr))
>> +               return ERR_CAST(sysmgr);
> 
> Don't use IS_ERR_OR_NULL(), it's just a sign that your API
> is bad. Instead, define the interface either so that you
> always return NULL on error or that you always return an
> PTR_ERR() value on error.
> 
OK. I will change this.

>> +struct regmap *altr_sysmgr_regmap_lookup_by_compatible(const char *s)
>> +{
>> +       struct device_node *sysmgr_np;
>> +       struct regmap *regmap;
>> +
>> +       if (!socfpga_is_s10())
>> +               return syscon_regmap_lookup_by_compatible(s);
>> +
>> +       sysmgr_np = of_find_compatible_node(NULL, NULL, s);
>> +       if (!sysmgr_np)
>> +               return ERR_PTR(-ENODEV);
>> +
>> +       regmap = altr_sysmgr_node_to_regmap(sysmgr_np);
>> +       of_node_put(sysmgr_np);
>> +
>> +       return regmap;
>> +}
>> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_compatible);
> 
> That should not be needed, just look it up by phandle and be done
> with it. Again, lookup by compatible should only be needed for
> compatibility with old DTB files, but you should be able to fix the
> binding so you always have a phandle to the correct node here,
> at least for the s10 case.
> 
> For the older chips with existing DTs, I guess drivers can fall back to
> the syscon method directly.
> 
>> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_pdevname);
> 
> Same comment.
> 
>          Arnd
> 
Yes. I will make these changes.

Thanks so much for the review!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
