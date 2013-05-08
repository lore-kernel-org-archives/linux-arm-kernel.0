From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 21:55:22 +0200
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <518A96DA.5060809@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <20130508143908.GJ24282@game.jcrosoft.org> <518A96DA.5060809@st.com>
Message-ID: <201305082155.23088.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> 
> On 08/05/13 15:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> +
> >> > 
> >> > Please remove all forward declarations, by reordering the functions in
> >> > the way they are called.
> >> > 
> > and drop the dummy functions
>
> We can not remove the dummy functions, as the serial-core does not check
> it before using them.

None of them seem performance critical, so it sounds reasonable to change
this in the core so you don't have to provide them. It's up to Greg to decide
whether he'd like that change or not.

	Arnd
