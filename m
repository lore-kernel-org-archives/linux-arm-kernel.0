From: roland@hack.frob.com (Roland McGrath)
Date: Fri,  7 Nov 2014 15:05:03 -0800 (PST)
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: Kees Cook's message of  Friday, 7 November 2014 08:44:18 -0800
 <CAGXu5jLBWiVieCkMFTboi5tEYw40O=-3_nH4jnMgKGQCrE6f1g@mail.gmail.com>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <353850534.aGkkrtTogX@wuerfel> <20141107131129.GF18916@arm.com>
 <6654405.Rf26mgoaDJ@wuerfel>
 <CAGXu5jLBWiVieCkMFTboi5tEYw40O=-3_nH4jnMgKGQCrE6f1g@mail.gmail.com>
Message-ID: <20141107230503.846942C3B00@topped-with-meat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not that I'm actually involved any more, but I'd endorse the user_regset
approach and not the new request.  On many (most?) machines, it's already
part of the main integer regset (orig_rax et al) and adding another
mechanism is redundant.  Using user_regset also means there won't be a word
of hidden state that is not visible in core dumps.
