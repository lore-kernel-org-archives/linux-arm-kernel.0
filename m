From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jun 2014 19:32:45 +0200
Subject: [PATCH v8 5/9] seccomp: split mode set routines
In-Reply-To: <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org>
 <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
Message-ID: <20140625173245.GA17695@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25, Andy Lutomirski wrote:
>
> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
> then set the bit.

Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().

But I still can't understand the rest of your discussion about the
ordering we need ;)

Oleg.
