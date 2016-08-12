From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 12 Aug 2016 13:40:18 -0500
Subject: [PATCH v3] ARM: VDSO: put RO and RO after init objects into
 proper sections
In-Reply-To: <CAGXu5jL9=R7mASn7JJnODOUbxQ-yDi9eV-92bZHvEep38ezbdQ@mail.gmail.com>
References: <1470989538-2953-1-git-send-email-jszhang@marvell.com>
 <CAGXu5jL9=R7mASn7JJnODOUbxQ-yDi9eV-92bZHvEep38ezbdQ@mail.gmail.com>
Message-ID: <b2e1495f-b172-45e5-7329-016687623f3a@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 01:06 PM, Kees Cook wrote:
> On Fri, Aug 12, 2016 at 1:12 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
>> vdso_data_mapping is never modified, so mark it as const.
>>
>> vdso_total_pages, vdso_data_page, vdso_text_mapping and cntvct_ok are
>> initialized by vdso_init(), thereafter are read only.
>>
>> The fact that they are read only after init makes them candidates for
>> __ro_after_init declarations.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> 
> Looks great; thanks for keeping __ro_after_init in mind. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Looks fine and nothing goes wrong with my vdso tests.  Please send it
through Russell.

Acked-by: Nathan Lynch <nathan_lynch@mentor.com>
