From: apenwarr@gmail.com (Avery Pennarun)
Date: Wed, 11 Aug 2010 12:18:02 -0400
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <1281542305.5107.11.camel@localhost>
References: <4C5F9B25.8080401@st.com>
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
	<1281542305.5107.11.camel@localhost>
Message-ID: <AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:58 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> In Evolution we have a workaround -- we don't just stop when we get to
> the reported RFC822.SIZE; we continue fetching more chunks until the
> server actually stops giving us any more. It's not as efficient (because
> we fall back to having only one more chunk outstanding at a time rather
> than the normal three in parallel), but at least it works around this
> brokenness of Exchange.
>
> http://git.gnome.org/browse/evolution-data-server/commit/?id=9714c064

Out of curiosity, why fall back to one chunk at a time?  It seems to
me that IMAP should be able to still support multiple outstanding
requests in that case, but you'd just get errors on the latter chunks.

It is just that there was no point optimizing the workaround case?

Have fun,

Avery
