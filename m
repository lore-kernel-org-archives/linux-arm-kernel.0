From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 18 Sep 2009 14:36:38 +0300
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <4AB36C9E.30902@nokia.com>
References: <f00f1348d91d2403ea0f1c5f05b3ac713664fe7b.1253281256.git.kirill@shutemov.name>
	<4AB36C9E.30902@nokia.com>
Message-ID: <cc557aab0909180436t845d9eanbac568977dff4947@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 2:18 PM, Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> What's the "insn" here?? And even if no IFAR is implemented, there should be
> IFSR. For NOMMU there should be pabort_noifsr simply returning zero values,
> similar to data abort handler.

No, both IFAR and IFSR is only implemented in ARMv7 so we have to handle
it together, I think.
