From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 22:31:35 +0100
Subject: [PATCH 06/12] pcie: designware: Move register definition to the
 header file
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <CAD6G_RTrETj9p+YNPjRMEFsO7Ggf3LfnuaPOSwO2brUcusNUJw@mail.gmail.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
Message-ID: <201312112231.36039.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Mohit KUMAR DCG wrote:
> > 
> > Seems like none were using these headers except pcie-designware.c - if ie
> > the case better to place it same place as before.
> 
> - We have include these and used few like ' PCIE_LINK_WIDTH_SPEED_CONTROL '  for SPEAr13xx platform, 
> so move these to the separate header  file.

I think it's better not to touch any of the registers from a platform-specific
driver. Better make a high-level function in the common code that the
spear driver can call to change this register.

	Arnd
