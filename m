From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 21 Oct 2014 17:19:01 +0530
Subject: [PATCH v3 6/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: <CAG374jBJcX00S4nSugWXaUxAQV3Bwp+OxY0c2GJ-+rskzDzpGw@mail.gmail.com>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>	<1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>	<15685.1412018368@turing-police.cc.vt.edu>
 <CAG374jBJcX00S4nSugWXaUxAQV3Bwp+OxY0c2GJ-+rskzDzpGw@mail.gmail.com>
Message-ID: <5446482D.2060909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 13 October 2014 01:46 PM, Gabriel Fernandez wrote:
> Hi Valdis,
> Thanks for your remark.
> 
> Concerning multiple writing in MIPHY_PLL_SBR_1, the writing of the
> first 0 it's to be sure there is no previous request.
> Then we take account new setting by writing 0x02.
> And then we make it 0 to make sure there is no other pending requests.
> 
> I added comments and macro to be more clear (see the code below).
> 
> 
> Hi Kishon,
> 
> Do you want a new patch set (v4),  or i wait other remarks from you ?

Apart from my comment below and for adding a common dt header file, rest of it
looks fine.
> 
> 
>     for (val = 0; val < 2; val++) {

What is "2" here? Lets add a macro for it.

Thanks
Kishon
