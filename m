From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Jul 2015 13:32:12 +0100
Subject: bug in identity map for 4KB pages?
In-Reply-To: <CAKv+Gu8uOO52xt+VX7YR5YHCN-Tan7mBRpR-xCJD33eE=vJcSA@mail.gmail.com>
References: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
 <20150729114258.GK15213@leverpostej>
 <CAKv+Gu-0NO5QnK34iXEK2_ATgsSYLMUwiq7u_=iPv5UrNba4kQ@mail.gmail.com>
 <CAKv+Gu8uOO52xt+VX7YR5YHCN-Tan7mBRpR-xCJD33eE=vJcSA@mail.gmail.com>
Message-ID: <20150729123212.GM15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> (replying to self) but actually, either solution still means that, of
> the ~16 GB this platform seems to have installed, only 2 GB is made
> available.
> 
> I suppose there is little we can do about it, since we cannot ignore
> the lower 2GB if the kernel resides there ...

Yup.

We need to cap memory for the general case anyway (e.g. 48 bits worth of
contiguous memory when the kernel only supports 39), and changes to
spasemem behaviour are orthogonal to that.

Mark.
