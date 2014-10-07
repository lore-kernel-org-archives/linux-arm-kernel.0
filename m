From: seraphin.bonnaffe@st.com (Seraphin Bonnaffe)
Date: Tue, 7 Oct 2014 15:22:26 +0200
Subject: [RFC PATCH 0/2] mfd: syscon: declare holes in syscon register maps
In-Reply-To: <54244655.1090801@st.com>
References: <54244655.1090801@st.com>
Message-ID: <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In reply to mail: Holes management in syscon driver. 

Hi Dong, Maxime, Lee, all,

Regmap also offers .rd_table and .wr_table structures that can be used to
specify valid ranges within agiven regmap configuration.

This patch uses these structures to declare holes in a syscon instance.
It takes the description from DT, and fills in the structures accordingly.

Can I have your opinion on this implementation ?

Thanks and Regards,
Seraphin

Seraphin Bonnaffe (2):
  mfd: syscon: Document new DT binding "holes"
  mfd: syscon: specify rd_table and wr_table from DT

 Documentation/devicetree/bindings/mfd/syscon.txt |  5 ++++
 drivers/mfd/syscon.c                             | 35 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
1.9.1
