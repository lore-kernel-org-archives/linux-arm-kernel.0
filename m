From: jcmvbkbc@gmail.com (Max Filippov)
Date: Thu, 7 Aug 2014 19:15:51 +0400
Subject: [PATCH 1/7] arm: use generic fixmap.h
In-Reply-To: <1407353564-21478-2-git-send-email-keescook@chromium.org>
References: <1407353564-21478-1-git-send-email-keescook@chromium.org>
 <1407353564-21478-2-git-send-email-keescook@chromium.org>
Message-ID: <CAMo8Bf+uq1vhqb7KxnNFHTZ53C1mtw_Do6dn09j7jjw_7MWF_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 6, 2014 at 11:32 PM, Kees Cook <keescook@chromium.org> wrote:
> ARM is different from other architectures in that fixmap pages are indexed
> with a positive offset from FIXADDR_START.  Other architectures index with
> a negative offset from FIXADDR_TOP.  In order to use the generic fixmap.h

Does anybody know if there's any reason why generic fixmap.h uses negative
offsets? It complicates things with no obvious benefit if you e.g. try to align
virtual address in the fixmap region with physical page color (that's why I've
switched xtensa to positive fixmap addressing in v3.17).

-- 
Thanks.
-- Max
