From: sophian.yoma@gmail.com (yoma sophian)
Date: Sun, 19 Aug 2018 00:01:33 +0800
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
Message-ID: <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(fix typo)
> > Switching between EL1_S and EL1_NS implies that EL3 is performing a
> > full
> > context switch of the system, similar to EL2 performing a switch
> > between
> > guests running at EL1_NS.
But here EL1_NS can directly modify TTBR0_EL1,
Since TTRB0_EL1 is accessible by EL1_NS and  it is not banked.
there is no need for switching to EL1_S at all.
thanks for your help,
