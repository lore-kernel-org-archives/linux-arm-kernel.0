From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 21 Jun 2011 19:35:45 -0400 (EDT)
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <8ya7h8edbhc.fsf@huya.qualcomm.com>
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
	<1308632955-11070-5-git-send-email-nico@fluxnic.net>
	<8yaliwueqr4.fsf@huya.qualcomm.com> <8ya7h8edbhc.fsf@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1106211931560.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jun 2011, David Brown wrote:

> On Tue, Jun 21 2011, David Brown wrote:
> 
> > On Mon, Jun 20 2011, Nicolas Pitre wrote:
> >
> >> +void *memmove(void *__dest, __const void *__src, size_t __n)
> >> +{
> >> +	unsigned char *d = __dest;
> >> +	const unsigned char *s = __src;
> >> +
> >> +	if (__dest == __src)
> >> +		return __dest;
> >> +
> >> +	if (__dest < __src)
> >> +		return memcpy(__dest, __src, __n);
> >> +
> >> +	while (--__n >= 0)
> >> +		d[__n] = s[__n];
> >> +
> >> +	return __dest;
> >> +}
> >
> > Ahh, found it.  size_t is unsigned, so the while loop never terminates.
> > Something like:
> >
> > 	for (; __n; __n--)
> > 		d[__n] = s[__n];
> 
> Ugh.  How about if I don't replace a broken version with a different
> broken version.

Blah.  I'll try to fetch the generic version in lib/string.c instead of 
duplicating that stuff.

Thanks for investigating.  I only was able to compile-test the thing so 
far.  ;-)


Nicolas
