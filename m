From: labbott@redhat.com (Laura Abbott)
Date: Mon, 30 Nov 2015 16:42:25 -0800
Subject: [PATCHv2] arm: Update all mm structures with section adjustments
In-Reply-To: <CAGXu5j+P2Y_dSJo=tK7hBNX_7hOiG23rA7nXcQ99csNA0_CSvA@mail.gmail.com>
References: <1447892054-8095-1-git-send-email-labbott@fedoraproject.org>
 <CAGXu5j+y1m9oONvCQg=MgrkwAgUV5OChoAY=q6vvyGNExY1Zjg@mail.gmail.com>
 <CAGXu5j+P2Y_dSJo=tK7hBNX_7hOiG23rA7nXcQ99csNA0_CSvA@mail.gmail.com>
Message-ID: <565CECF1.6090101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 03:40 PM, Kees Cook wrote:
> On Thu, Nov 19, 2015 at 11:10 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Nov 18, 2015 at 4:14 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>>> Currently, when updating section permissions to mark areas RO
>>> or NX, the only mm updated is current->mm. This is working off
>>> the assumption that there are no additional mm structures at
>>> the time. This may not always hold true. (Example: calling
>>> modprobe early will trigger a fork/exec). Ensure all mm structres
>>> get updated with the new section information.
>>>
>>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>>
>> This looks right to me. :)
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Russell, does this work for you?
>
> Did this end up in the patch tracker? (I just sent a patch that'll
> collide with this... I'm happy to do the fix up.)
>

I put this in the patch tracker this morning.
  
> -Kees
>

Thanks,
Laura
