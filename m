From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 15:26:17 -0800
Subject: [PATCH 1/3] ARM: tegra: seaboard: register i2c devices
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF045687B8E2@HQMAIL01.nvidia.com>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<1299486399-21761-2-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF045687B855@HQMAIL01.nvidia.com>
	<AANLkTin6kCEnOFuua70ze4D3igtZuUEVTNRf4zq-qD4D@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF045687B8E2@HQMAIL01.nvidia.com>
Message-ID: <AANLkTin9+LDSPPzECaEwUAac_OwcuARQGUFnakxXUkOG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 7, 2011 at 11:39 AM, Stephen Warren <swarren@nvidia.com> wrote:


>> They are now -- they weren't when all i2c devices were registered. I
>> can re-join them and split them when devices are re-introduced later.
>
> Perhaps move the common code into common_i2c_init, then put only the
> differences in ${boardname}_i2c_init(), which would currently be empty
> except to call the common function?

I'll split up again when the need arises, i.e. when the
differentiating drivers are introduced for now, I just made a common
seaboard_i2c_init that's called from the common init function, i.e.
undid the per-board split.


-Olof
