From: omycle@gmail.com (Li Haifeng)
Date: Mon, 4 Feb 2013 18:29:53 +0800
Subject: Qestion about page->_count and page reclaim
Message-ID: <CAFNq8R4MBqgJX=dxkS8Rxi-19MwiX7ChS7gx9FXSs-easMVzvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all in kernel.

The page->_count is the page frame's usage count.
When page is allocated, the page will be refcounted, and page->_cout will
be set 1.

After be allocated from buddy system, the page will be used by process.
 get_page and put_page/put_page_testzero will used in pairs. is it right?

When the page is reclaimed to buddy system, the page->_count should be 0.
However, Because the initialization of page->_count is 1, get_page() and
put_page() is called in pairs, I coufused how page->_count will be 0?

Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/7de0ef46/attachment-0001.html>
