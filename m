From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Fri, 3 Feb 2017 10:56:34 -0500
Subject: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
In-Reply-To: <CACRpkdbAYyxTOq_ZAwjSJAhCbrzTaUMSG9N7t8Wq1ifTDFBLrQ@mail.gmail.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com>
 <7bc0871f-ac0a-e8a0-0c84-a0e61b3991a8@savoirfairelinux.com>
 <CACRpkdbAYyxTOq_ZAwjSJAhCbrzTaUMSG9N7t8Wq1ifTDFBLrQ@mail.gmail.com>
Message-ID: <3f3cd438-63dc-dea8-e17b-7eb3e588cc36@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 02/03/2017 08:51 AM, Linus Walleij wrote:
> Your child nodes I guess will be instatiated as devices as well.
> 
> These devices will have the NBUS driver as .parent in their
> struct device I guess. Else the design of this bus is tilted.
> 
> If the NBUS driver use dev_set_drvdata(dev, state_container_cookie)
> the children can use dev_get_drvdata(dev->parent); to get a pointer to
> the same cookie.
> 
> The subdrivers don't even need to know the members of the state
> container as long as you're just passing a pointer to it. It's
> enough if you forward-declare it as a "pointer to some struct":
> 
> struct foo;
> 
> {
>    struct foo *fooptr = dev_get_drvdata(dev->parent);
>    write(fooptr, 0x10);
> 
> etc

Thanks a lot, this is perfect!

Best Regards,
Sebastien.
