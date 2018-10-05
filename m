From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 5 Oct 2018 23:38:06 +0200
Subject: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if null
In-Reply-To: <20181004195605.txvbkshvxklyzxyb@flea>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
 <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
 <20181004195605.txvbkshvxklyzxyb@flea>
Message-ID: <5c45b263-e310-82af-ffb3-85eac93622d5@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 04/10/2018 21:56, Maxime Ripard ha scritto:
> On Wed, Oct 03, 2018 at 04:24:58PM +0200, Giulio Benetti wrote:
>> If using tcon with VGA,
> 
> We don't have support for VGA at the moment. Or are you talking about
> using a VGA bridge?

You're right, in general VGA is not the point.
tcon->panel is retrieved by drm_of_find_panel_or_bridge() and panel can 
be present or not.

>> tcon->panel will be null(0), this will cause segmentation fault when
>> trying to dereference tcon->panel->connector.
> 
> It's not a segmentation fault, but a null pointer dereference. And
> that case will also happen with bridges.

Right.

Going to improve/rewrite commit logs and submit v2 patchset.

Thanks for reviewing.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
