Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22BCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:11:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5492082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OTfI1zQ4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z+Li+Hma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5492082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ElFcbgnjXMjRuMmvbPCoBsM3ZECffbxRQDe9dUOT0+g=; b=OTfI1zQ4B9VnSS
	2RekjmdvH/lFbf2naKIPtoKSLWxk1uxd28Q0UXPc/Nqq2g1MCiwvv3UOfkLQSDAf2oaC86dnJXLwc
	b47x/PnvufXF0c2BEjNFGkyQPpQKBsz3/LsBHyjaOBTHMn5qcvww04SQaOzViwlRkjl5I4TKJ9hFL
	zlGuEbZ5KaR/pU5INk/xfmc7CvcD3x6OKx02HzBIf64fBSk2wV8NSxbJqeJFPVP5cFFNH4pIq544g
	5AB6DaEFn6Vxy4JXQrArl896+Yec0Qj8igxVXG8RFv2ZIuN58AVSifYhnI8UhZP1wWwP7xlPoGEvj
	yOPQ690lWz6NulrckRNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTDb-0000Hv-RN; Wed, 05 Dec 2018 09:11:43 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTDM-0000HF-8i
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:11:29 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0796360000>; Wed, 05 Dec 2018 01:11:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 05 Dec 2018 01:11:17 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 05 Dec 2018 01:11:17 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 5 Dec 2018 09:11:16 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 3CDB040447; Wed,  5 Dec 2018 11:11:14 +0200 (EET)
Date: Wed, 5 Dec 2018 11:11:14 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
Message-ID: <20181205091114.GF26056@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
 <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
 <1cbe2662-1b5e-8261-f0c1-04a760cb08c1@nvidia.com>
 <7f90eae3-42fe-e771-b2f0-421c617db11e@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f90eae3-42fe-e771-b2f0-421c617db11e@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544001078; bh=at3IDFyqSdqI0GgINh0GwZ7yV9fzT+4qu6e7Q+udJpo=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
 User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=Z+Li+HmaM8Lt/0/0SQNgfICiGUfo85hcwXUQwEwOYvK9FAUap7BUK1xm5suKbWPM5
 sGtPb5diQ92UrSGaVOJV3hHXtuB88hwd8qVzK9lxrNiFjwhpEP0Go1Zdb4nXMYpXYV
 P1hX/tgu7bji46B95RDny1jXVat5W/Ce9hH2G6soIthGgIePfCPy6Kd8lgQ8uvS2nj
 /MxAvi/8fKhj7ALKVUdvCGbozQBYhJT1fHm41HNJWPALwpvHEBQ9NMk5dlQdZSXCvk
 RZpfsHpd5b1scTmlv9gReXVE0R80Y30yn/UeaiGpFB+q5e/Lg3OGirN81GuKXovvtt
 s0bH6TkGjSMdQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_011128_319768_AC66238D 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 02:51:07PM +0800, Joseph Lo wrote:
> On 12/5/18 2:20 PM, Joseph Lo wrote:
> > On 12/4/18 11:46 PM, Peter De Schrijver wrote:
> > > On Tue, Dec 04, 2018 at 05:25:37PM +0800, Joseph Lo wrote:
> > > > When generating the OPP table, the voltages are round down with the
> > > > alignment from the regulator. The alignment should be applied for
> > > > voltages look up as well.
> > > > =

> > > > Based on the work of Penny Chiu <pchiu@nvidia.com>.
> > > > =

> > > > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > > > ---
> > > > =A0 drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
> > > > =A0 1 file changed, 15 insertions(+), 11 deletions(-)
> > > > =

> > > > diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-d=
fll.c
> > > > index c294a2989f31..4a943c136d4d 100644
> > > > --- a/drivers/clk/tegra/clk-dfll.c
> > > > +++ b/drivers/clk/tegra/clk-dfll.c
> > > > @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct
> > > > tegra_dfll *td)
> > > > =A0 static int find_lut_index_for_rate(struct tegra_dfll *td,
> > > > unsigned long rate)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 struct dev_pm_opp *opp;
> > > > -=A0=A0=A0 int i, uv;
> > > > +=A0=A0=A0 int i, align_volt;
> > > > =A0=A0=A0=A0=A0 opp =3D dev_pm_opp_find_freq_ceil(td->soc->dev, &ra=
te);
> > > > =A0=A0=A0=A0=A0 if (IS_ERR(opp))
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(opp);
> > > > -=A0=A0=A0 uv =3D dev_pm_opp_get_voltage(opp);
> > > > +=A0=A0=A0 align_volt =3D dev_pm_opp_get_voltage(opp) /
> > > > td->soc->alignment.step_uv;
> > > > =A0=A0=A0=A0=A0 dev_pm_opp_put(opp);
> > > > =A0=A0=A0=A0=A0 for (i =3D td->lut_bottom; i < td->lut_size; i++) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (regulator_list_voltage(td->vdd_reg, td->=
lut[i]) =3D=3D uv)
> > > > +=A0=A0=A0=A0=A0=A0=A0 if ((td->lut_uv[i] / td->soc->alignment.step=
_uv) >=3D align_volt)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return i;
> > > > =A0=A0=A0=A0=A0 }
> > > > @@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
> > > > =A0=A0 */
> > > =

> > > These 2 functions are only valid for I2C mode. We should probably add=
 a
> > > WARN_ON() in case they are called when PWM mode is used and return
> > > -EINVAL.
> > > =

> > =

> > Okay, will add that.
> > =

> Peter,
> =

> Sorry, just double check again. These 2 functions are used for generating
> LUT table for DFLL-I2C mode. They are only used in "dfll_build_i2c_lut"
> function. So I think it's fine. The WARN_ON for protection from PWM mode =
is
> not necessary.
> =


They are indeed not used today, but to prevent them from being used in
the future I was thinking it makes sense to add some form of protection
here.

Peter.

> =

> > =

> > > > =A0 static int find_vdd_map_entry_exact(struct tegra_dfll *td, int =
uV)
> > > > =A0 {
> > > > -=A0=A0=A0 int i, n_voltages, reg_uV;
> > > > +=A0=A0=A0 int i, n_voltages, reg_volt, align_volt;
> > > > +=A0=A0=A0 align_volt =3D uV / td->soc->alignment.step_uv;
> > > > =A0=A0=A0=A0=A0 n_voltages =3D regulator_count_voltages(td->vdd_reg=
);
> > > > =A0=A0=A0=A0=A0 for (i =3D 0; i < n_voltages; i++) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 reg_uV =3D regulator_list_voltage(td->vdd_re=
g, i);
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (reg_uV < 0)
> > > > +=A0=A0=A0=A0=A0=A0=A0 reg_volt =3D regulator_list_voltage(td->vdd_=
reg, i) /
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 td->soc->alignment.s=
tep_uv;
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (reg_volt < 0)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (uV =3D=3D reg_uV)
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (align_volt =3D=3D reg_volt)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return i;
> > > > =A0=A0=A0=A0=A0 }
> > > > @@ -1554,15 +1556,17 @@ static int
> > > > find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
> > > > =A0=A0 * */
> > > > =A0 static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
> > > > =A0 {
> > > > -=A0=A0=A0 int i, n_voltages, reg_uV;
> > > > +=A0=A0=A0 int i, n_voltages, reg_volt, align_volt;
> > > > +=A0=A0=A0 align_volt =3D uV / td->soc->alignment.step_uv;
> > > > =A0=A0=A0=A0=A0 n_voltages =3D regulator_count_voltages(td->vdd_reg=
);
> > > > =A0=A0=A0=A0=A0 for (i =3D 0; i < n_voltages; i++) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 reg_uV =3D regulator_list_voltage(td->vdd_re=
g, i);
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (reg_uV < 0)
> > > > +=A0=A0=A0=A0=A0=A0=A0 reg_volt =3D regulator_list_voltage(td->vdd_=
reg, i) /
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 td->soc->alignment.s=
tep_uv;
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (reg_volt < 0)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (uV <=3D reg_uV)
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (align_volt <=3D reg_volt)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return i;
> > > > =A0=A0=A0=A0=A0 }
> > > > -- =

> > > > 2.19.2
> > > > =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
