From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 13 Oct 2017 11:13:00 -0700
Subject: [PATCH v2 3/10] arm: vdso: inline assembler operations to
 compiler.h
In-Reply-To: <20171012225940.86652-1-salyzyn@android.com>
References: <20171012225940.86652-1-salyzyn@android.com>
Message-ID: <24d5a48b-620e-2112-2de8-fb42e403ea57@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2017 03:59 PM, Mark Salyzyn wrote:
> Move compiler-specific code to a local compiler.h file. CONFIG_AEABI
> dependency check. System call fallback functions standardized into
> a DEFINE_FALLBACK macro. Accept that __arch_counter_get_cntvct()
> is the API for aarch64. Deal with unresolved references emitted by
> GCC. Optimize handling of fallback calls. Most notably add unlikely
> nullptr checking to __vdso_gettimeofday, if tv null no need to
> proceed to fallback, as vdso is capable of filling in the tv values.
nit: last sentence should have read 'filling in the tz values.'
