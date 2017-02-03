From: dhowells@redhat.com (David Howells)
Date: Fri, 03 Feb 2017 16:21:58 +0000
Subject: [PATCH 7/7] efi: Print the secure boot status in x86 setup_arch()
 [ver #7]
In-Reply-To: <CAKv+Gu8otPYWcKw72zP2q+34JAzZ-QRy8xGFmbStO6WseeANdw@mail.gmail.com>
References: <CAKv+Gu8otPYWcKw72zP2q+34JAzZ-QRy8xGFmbStO6WseeANdw@mail.gmail.com>
 <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
Message-ID: <13280.1486138918@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > +       if (IS_ENABLED(CONFIG_EFI)) {
> 
> Shouldn't this be a runtime check?

Interesting question.  The original patch I was working from had a #ifdef
here.  Possibly it doesn't need to be there at all.  We could rely entirely on
the value of boot_params.secure_boot.

David
