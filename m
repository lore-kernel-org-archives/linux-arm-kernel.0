From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 22:30:09 +0200
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for
 Apr 4
In-Reply-To: <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
References: <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd>
 <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
 <20180420192832.GA1870@amd>
 <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
Message-ID: <20180420203009.GA2244@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-04-20 15:30:03, Daniel Micay wrote:
> Well, that's not related, it's just this:
> 
> #ifdef __GNUC__
> #if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> #error Your compiler is too buggy; it is known to miscompile kernels.
> #error    Known good compilers: 3.3, 4.x
> #endif
> #if GCC_VERSION >= 40800 && GCC_VERSION < 40803
> #error Your compiler is too buggy; it is known to miscompile kernels
> #error and result in filesystem corruption and oopses.
> #endif
> #endif

Yeah, I know. I guess the kernel would compile if I removed those
checks... 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/988bf88a/attachment.sig>
