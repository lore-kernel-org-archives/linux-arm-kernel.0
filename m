From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 12:40:50 +0100
Subject: [PATCHv2] arm: crypto: Add optimized SHA-256/224
In-Reply-To: <20150324113502.GE11405@gondor.apana.org.au>
References: <20150316154835.GA31336@google.com>
 <20150323135009.GB820@google.com>
 <CAKv+Gu8qcVVTqy6Fd8PMA8ZTxiMssKz+TbMQW=fAhCBpUH2jTw@mail.gmail.com>
 <20150324113502.GE11405@gondor.apana.org.au>
Message-ID: <CAKv+Gu9RtkorW1qiX4xohxDYQ-SfbFnY0NgeiXCxdZ1xx6SA9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2015 at 12:35, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Mar 23, 2015 at 07:26:03PM +0100, Ard Biesheuvel wrote:
>> (resending due to size bounce)
>
> Aha that's why the patch didn't make it through.  Can it be split
> up?

Not so easily. It consists (among other things) of a .pl file that
generates a .S file, but to prevent introducing a build time
dependency on perl, the .S file is included as a .S_shipped file. That
is the big one.

i suppose we could add the .S_shipped file in a separate patch, but
I'd prefer to keep it as is
