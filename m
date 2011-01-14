From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 08:35:24 +0000
Subject: [PATCH] mm/init.c: fix compilation warning
In-Reply-To: <1294989051-830-1-git-send-email-viresh.kumar@st.com>
References: <1294989051-830-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20110114083524.GK24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 12:40:51PM +0530, Viresh Kumar wrote:
> This patch fixes following warning:
> mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but
> argument 12 has type 'unsigned int'

The problem is in your definition of VMALLOC_END.  It should be typed
unsigned long - so have a UL suffix on the number.
