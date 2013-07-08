From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 01:18:06 +0200
Subject: [PATCH v1 0/4] ARM: STi fixes and ethernet support
In-Reply-To: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201307090118.06715.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 July 2013, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch series fixes 2 configuration issues and adds ethernet support to
> STiH415, STiH416 based B2000, B2020 boards.
> With this patchset B2000 and B2020 can have basic ethernet support in
> MII and RGMII modes.
> 
> Thanks,
> srini
> 
> Srinivas Kandagatla (4):
>   ARM: dts: STi: Fix pinconf setup for STiH416 serial2
>   ARM: STi: Set correct ARM ERRATAs.
>   ARM: STi: Add STiH415 ethernet support.
>   ARM: STi: Add STiH416 ethernet support.

Hi Srini,

You really have to send those things separately, as the bug fixes should
probably go into 3.11, while the rest is new features and needs to be
reviewed for merging into 3.12.

I'm also puzzled by the fact that you add auxdata and callback
functions for the ether part in the platform code. Those should
probably all be properties added to the stmmac binding.

	Arnd
