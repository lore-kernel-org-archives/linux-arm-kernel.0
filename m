From: danielmicay@gmail.com (Daniel Micay)
Date: Fri, 20 Apr 2018 15:30:03 -0400
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for
 Apr 4
In-Reply-To: <20180420192832.GA1870@amd>
References: <20180404175852.GI5700@atomide.com> <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd>
 <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
 <20180420192832.GA1870@amd>
Message-ID: <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, that's not related, it's just this:

#ifdef __GNUC__
#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
#error Your compiler is too buggy; it is known to miscompile kernels.
#error    Known good compilers: 3.3, 4.x
#endif
#if GCC_VERSION >= 40800 && GCC_VERSION < 40803
#error Your compiler is too buggy; it is known to miscompile kernels
#error and result in filesystem corruption and oopses.
#endif
#endif
