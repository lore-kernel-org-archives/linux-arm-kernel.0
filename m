From: joe@perches.com (Joe Perches)
Date: Fri, 05 Dec 2014 20:24:25 -0800
Subject: [PATCH 2/5] gpio: Cygnus: add GPIO driver
In-Reply-To: <54827B07.3000707@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1417826408-1600-1-git-send-email-rjui@broadcom.com>
 <1417826408-1600-3-git-send-email-rjui@broadcom.com>
 <1417829282.31745.3.camel@perches.com> <5482668F.1040907@broadcom.com>
 <1417833291.31745.5.camel@perches.com> <54827B07.3000707@broadcom.com>
Message-ID: <1417839865.31745.10.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-05 at 19:41 -0800, Ray Jui wrote:
> On 12/5/2014 6:34 PM, Joe Perches wrote:
> > On Fri, 2014-12-05 at 18:14 -0800, Ray Jui wrote:
> >> On 12/5/2014 5:28 PM, Joe Perches wrote:
> >>> On Fri, 2014-12-05 at 16:40 -0800, Ray Jui wrote:
> >>>> +			for_each_set_bit(bit, &val, 32) {
[]
> Actually, by reviewing the code more deeply, I'm not sure why using 
> for_each_set_bit here is 'endian unsafe'.

It's not.  The 32 confused me as it was long
and sizeof(long) isn't necessarily 32.

Maybe the 32 should be a #define
